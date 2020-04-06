a = integer(length = 10)
print(a)
n = length(a)
for (i in 1:n) {
  a[i]<-a[i]+1
  print(a)
}
print(a)