#'Land Use and Land Cover
#'
#'Performing land use and land cover mapping through machine learning, based on Filho et al. (2024).
#'
#'@param x Input stack raster files.
#'@param y Input samples (vector files) in terra or sf package R.
#'@param target_col Numeric. Target field of occurrence.
#'@param p Numeric. Regarding the number of samples representing the non-occurrence of events, it is suggested, in order to balance the sample set, to use a sample size equal to the number of event occurrences.
#'@param drop_cols This allows you to remove information that will not be used in susceptibility modeling.
#'@param k_folds Numeric. Number of folds or number of resampling iterations, using cross-validation method.
#'@param method Random Forest 'rf' or Support Vector Machine 'svm'
#'@param mtry Numeric. Randomly selected predictors
#'@param ntree Numeric. Decision tree number
#'@param cost Numeric. Constraint violation cost, where 'C' is the regularization parameter.
#'@param preProcess Estimates the required parameters for each operation (e.g., 'nzv' for near-zero variance filtering, or c('center', 'scale') for normalization). For details on available pre-processing methods, see the caret package R documentation.
#'@param path_var_imp Character. Path to save the machine learning model variable importance in tabular format.
#'@param path_prediction Character. Path to save the susceptibility prediction in raster/matrix format.
#'
#'@examples
#' library(pacman)
#' p_load(terra, rgeoamb)
#' rasters <- terra::rast(system.file("ex/stack.tif", package = "terra"))
#' samples <- terra::vect(system.file("ex/samples.shp", package = "terra"))
#' lulc <- rgeoamb::landuse_landcover(rasters, samples, "classes", 0.7, -c(1, 2, 10), 4, 'rf', 6, 500, NULL,
#'                                              "nzv", "ex/var_imp.txt", "ex/predict.tif")
#' plot(lulc)
#'@export
landuse_landcover <- function(x, y, target_col, p, drop_cols, k_folds, method, mtry, ntree, cost, preProcess, path_var_imp, path_prediction){
  dataset <- x|>
    terra::extract(y, bind = T)|>
    sf::st_as_sf()|>
    as.data.frame()
  dataset[[target_col]] <- as.factor(dataset[[target_col]])
  data_partition <- createDataPartition(dataset[, target_col], p = p, list = F)
  train <- dataset[data_partition, drop_cols]
  colSums(is.na(train))
  train <- na.omit(train)
  length(train[[target_col]])
  test <- dataset[-data_partition, drop_cols]
  colSums(is.na(test))
  test <- na.omit(test)
  length(test[[target_col]])
  cv_folds <- createFolds(train[[target_col]], k = k_folds, returnTrain = T, list = T)
  trControl <- trainControl(method = 'cv', search = 'grid', index = cv_folds,  allowParallel = T)
  form <- as.formula(paste(target_col, "~ ."))
  if(method == 'rf'){
    tuneGrid = expand.grid(mtry = seq(1, mtry, by = 1))
    model <- train(form, data = train, method = 'rf', ntree = ntree, metric = 'Accuracy',
                   trControl = trControl, tuneGrid = tuneGrid, preProcess = preProcess)
  } else if (method == 'svm'){
    tuneGrid <- expand.grid(C = seq(0.1, cost, by = 0.2))
    model <- train(form, data = train, method = 'svmLinear',
                   trControl = trControl, tuneGrid = tuneGrid, preProcess = preProcess)
  } else{
    print("method must be 'rf' or 'svm'")
  }
  print(method)
  pred <- caret::predict.train(model, test)
  cm <- caret::confusionMatrix(pred, test[[target_col]])
  by_class <- as.data.frame(cm$byClass)
  accuracy <- cm$overall['Accuracy']
  precision <- by_class['Pos Pred Value']
  names(precision) <- 'precision'
  recall <- by_class['Sensitivity']
  names(recall) <- 'recall'
  f1_score <- 2 * (precision * recall)/(precision + recall)
  names(f1_score) <- 'f1_score'
  metrics <- data.frame(
    classes = rownames(by_class),
    accuracy = accuracy,
    precision = precision,
    recall = recall,
    f1_score = f1_score)
  print(metrics)
  imp <- caret::varImp(model, scale = T)$importance|>
    as.data.frame()
  print(imp)
  write.table(imp, path_var_imp, append = F)
  model_class <- terra::predict(x, model, progress = "text", type = "raw", na.rm = T)
  print(model_class)
  writeRaster(model_class, path_prediction, overwrite = T)
}
