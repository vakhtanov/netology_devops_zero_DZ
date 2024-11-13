#Задание 1

```python
# cook your dish here
boys = ['Peter', 'Alex', 'John', 'Arthur', 'Richard']
girls = ['Kate', 'Liza', 'Kira', 'Emma', 'Trisha']

if len(boys)!=len(girls):
    print('Не всем хватает пары')
    exit(0)

ideal = zip(sorted(boys),sorted(girls))

print('Идеальные пары:')

for pair in ideal:
    print (f'{pair[0]} и {pair[1]}')
```
