n = int(input())
l = list(map(int, input().split()))
mindi = abs(l[0]-l[1])
for i in range(len(l)):
    for j in range(i+1, len(l)):
        mindi = min(mindi, abs(l[i]-l[j]))
print(mindi)
l.sort()
print(l)
for i in range(len(l)-1):
    if abs(l[i]-l[i+1]) == mindi:
        print(l[i], end=" ")
        print(l[i+1], end=" ")
