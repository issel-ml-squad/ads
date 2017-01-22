##' A class responsible for saving to and reading from files (.csv, .png, .xml)
##'
##' @include Server.R
##' @import methods
##' @export FileManipulator
##' @exportClass FileManipulator
FileManipulator <- setRefClass(Class = "FileManipulator",
                                 fields = list(
			             directories_ = "list"

                                 ),
                                 methods = list(
                                   loadDataset = function(name, ...) {
                                     'Loads file specified by name in repository with datasets into a data.frame'
                                     # get directory of datasets
                                     workspace_dir <- directories_$Workspace
                                     str(workspace_dir)
                                     # create path to file
                                     dataset_path <- paste(workspace_dir, "datasets_repo", name, sep = "/" )
                                     # read file into data.frame
                                     dataset <- read.csv(dataset_path,
                                                         header = TRUE, sep=",", stringsAsFactors=FALSE)
                                     # call preprocessor to format dataset
                                     # set server's information
                                     return(dataset)
                                   },
                                   loadOrderedDictionary = function(...) {
                                     'Loads dictionary of words indicating ordered features.'
                                     # get ADS Workspace
                                     workspace_dir <- directories_$Workspace
                                     # create path to file
                                     file_path <- file.path(workspace_dir, "heuristics_repo/ordered_dictionary.csv")
                                     # load file
                                     dic <- read.csv(file_path, header = TRUE, sep=",", stringsAsFactors=FALSE)
                                     return(dic)
                                   },
                                   saveModel = function(...) {
                                     'Saves a trained machine learning model and returns important info'
                                     model_info <- list()
                                     return(model_info)
                                   },
                                   saveEnsemble = function(included_models, predictions, ...) {
                                     'Saves built ensemble'
                                     # save all models
                                     models_info <- list()
                                     for(model in included_models) {
                                       models_info[[model$method]] <- saveModel(model)
                                     }
                                     # save txt with info about ensemble(included models, tuning process, ...)
                                   },
                                   saveDataset = function(dataset, directory, ...){
                                     'Saves a data.frame into a .csv file.'
                                     # create path to file
                                     # save dataset
                                   },
                                   saveXml = function(name, procedure) {
                                     'Saves in "name.xml" the procedure(newXMLNode) of the experiment.'
                                     # get path to save to  from server
                                     # define path+file
                                     # save procedure
                                     saveXML(procedure)
                                   },
                                   savePng = function(name, plot) {
                                     'Saves a plot to a "name".png.'
                                     # get path to save to from server
                                     # define image path
                                     # open png device
                                     png(filename = image_path)
                                     # plot
                                     # close png device
                                     dev.off()

                                   },
                                   setDirectories = function(directories, ...) {
                                    directories_ <<- directories                                  
                                   },

                                   initialize=function(...) {
                                     directories_ <<- list( Workspace = "yo")

                                     callSuper(...)
                                     .self
                                   }
                                 )
)