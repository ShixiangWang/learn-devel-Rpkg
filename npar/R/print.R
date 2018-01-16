#' @title 打印多重比较的结果
#'
#' @description
#' \code{print.oneway} 打印多重组间比较的结果
#'
#' @details
#' 这个函数打印出用 \code{\link{oneway}} 函数所创建的Wilcoxon成对多重比较的结果 
#' 
#' @param x 一个 \code{oneway}类型的变量
#' @param ... 要传输给函数的额外的变量
#' @method print oneway
#' @export
#' @return 静默返回输入的变量
#' @author Rob Kabacoff <rkabacoff@@statmethods.net>
#' @examples
#' results <- oneway(hlef ~ region, life)
#' print(results)
print.oneway <- function(x, ...){
  if (!inherits(x, "oneway"))       
    stop("Object must be of class 'oneway'")
  
  cat("data:", x$vnames[1], "by", x$vnames[2], "\n\n")  
  cat("Multiple Comparisons (Wilcoxon Rank Sum Tests)\n")
  cat(paste("Probability Adjustment = ", x$method, "\n", sep=""))
  
  print(x$wmc,  ...)
}
