#' @title 汇总单因子非参分析的结果
#'
#' @description
#' \code{summary.oneway} 汇总了单因子非参分析的结果
#'
#' @details
#' 这个函数对\code{\link{oneway}}函数所分析的结果进行汇总并打印。这包括了每一组的
#' 描述性统计量，一个综合的Kruskal-Wallis检验的结果，以及一个Wilcoxon成对多重比较
#' 的结果
#' 
#' @param object 一个\code{oneway}类型的对象
#' @param ... 额外的参数
#' @method summary oneway
#' @export
#' @return 静默返回输入的对象
#' @author Rob Kabacoff <rkabacoff@@statmethods.net>
#' @examples
#' results <- oneway(hlef ~ region, life)
#' summary(results)
summary.oneway <- function(object, ...){
  if (!inherits(object, "oneway")) 
    stop("Object must be of class 'oneway'")
    
  if(!exists("digits")) digits <- 4L
  
  kw <- object$kw
  wmc <- object$wmc
  
  cat("data:", object$vnames[1], "on", object$vnames[2], "\n\n")
  
  cat("Omnibus Test\n")                        
  cat(paste("Kruskal-Wallis chi-squared = ", 
             round(kw$statistic,4), 
            ", df = ", round(kw$parameter, 3), 
            ", p-value = ", 
               format.pval(kw$p.value, digits = digits), 
            "\n\n", sep=""))
  
  cat("Descriptive Statistics\n")     
  print(object$sumstats, ...)
  
  
  wmc$stars <- " "                  
  wmc$stars[wmc$p <   .1] <- "."
  wmc$stars[wmc$p <  .05] <- "*"
  wmc$stars[wmc$p <  .01] <- "**"
  wmc$stars[wmc$p < .001] <- "***"
  names(wmc)[which(names(wmc)=="stars")] <- " "                          
  
  cat("\nMultiple Comparisons (Wilcoxon Rank Sum Tests)\n")    
  cat(paste("Probability Adjustment = ", object$method, "\n", sep=""))
  print(wmc, ...)
  cat("---\nSignif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1\n")
}
