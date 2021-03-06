# R-stock-price-alert-tool
# R script that alerts you via email when a certain stock leaves a price channel
# Call your libraries
# Email bradley.lindblad@gmail.com with suggestions, comments
library(quantmod)
library(mailR)

# Build fn to alert when a stock goes above or below a certain price
# Function is called "price_alert_fn"
price_alert_fn <- function(x = ticker, y = alert.if.price.less.than, z = alert.if.price.greater.than){
  stock <- x
  less_than_target <- y
  greater_than_target <- z
  stock1 <- getSymbols(stock, src = 'google', auto.assign = FALSE)
  stock2 <- as.data.frame(stock1)
  last_close <- tail(stock2, n = 1)
  last_close <- as.numeric(last_close[,4])
  last_close
  
  # This aspect of the function sends you an email with the mailR package if the last close satisfies one of your criteria
  # This example uses Gmail, but other services will work. Replace "youremail@gmail" with your email, obvi
  if((last_close - less_than_target)<0){
    send.mail(from = "youremail@gmail.com",
              to = c("youremail@gmail.com","recipient 3 <youremail@gmail.com>"),
              replyTo = c("Reply to someone else <youremail@gmail.com>"),
              subject = "Alert - Action on a Stock in Your Portfolio",
              body = paste('alert, less than target',less_than_target, 'met for:', stock,'last close:', last_close),
              smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "your gmail user", passwd = "your gmail password", ssl = TRUE),                                                                                                                               
              authenticate = TRUE,
              send = TRUE)  
  }
  if((last_close - greater_than_target)>0){
    send.mail(from = "youremail@gmail.com",
              to = c("youremail@gmail.com"),
              replyTo = c("Reply to someone else <youremail@gmail.com>"),
              subject = "Alert - Action on a Stock in Your Portfolio",
              body = paste('alert, greater than target',greater_than_target, 'met for:', stock,'last close:', last_close),
              smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "your gmail user", passwd = "your gmail password", ssl = TRUE),
              authenticate = TRUE,
              send = TRUE)  
  }
  
}


# This is where you call your function and insert your stock ticker and your upper and lower limits 
# I use Windows Task Scheduler to run this program every night, so I get an email after the close for that day 
## STOCK = LIT ##
price_alert_fn(x = 'LIT', y = 33.8, z = 44.4)  #Here, I want to know when LIT (Lithium ETF) either falls below $33.8 (close price) or above $44.40 (close price)

## STOCK = IEP ##
price_alert_fn(x = 'IEP', y = 46.8, z = 62.4)

## STOCK = HRI ##
price_alert_fn(x = 'HRI', y = 55.8, z = 74.4)

## STOCK = RDWR ##
price_alert_fn(x = 'RDWR', y = 17.73, z = 23.7)
