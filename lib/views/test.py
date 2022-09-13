def sum(n,k):
    print(k)
    if n ==2:
        return 2
    else:
        return (n+sum(n-2,k+1))
sum(30,1)