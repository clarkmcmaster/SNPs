x <- c('aaa','bbb','ccc','ddd')
y <- c('1','2','3','4')
vt <- data.frame(x,y)
vt <- t(vt)
df <- t(df)
vt[x] <- toupper(vt[x])
for(i in x){
  print(i)
}

df <- data.frame('aaa'=c(1:4),'bbb'=c(1:4),'ccc'=c(1:4),'ddd'=c(1:4))

for(i in colnames(df)){
  colnames(df)[which(vt$x == "i")]
  colnames(df)[indx] <- vt$y[indx]
}

colnames(df)[which(vt$x == colnames$df)] <- 
