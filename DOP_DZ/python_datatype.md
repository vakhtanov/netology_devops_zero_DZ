# Задание 1

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

# Задание 2

```python
cook_book = [
  ['салат',
      [
        ['картофель', 100, 'гр.'],
        ['морковь', 50, 'гр.'],
        ['огурцы', 50, 'гр.'],
        ['горошек', 30, 'гр.'],
        ['майонез', 70, 'мл.'],
      ]
  ],
  ['пицца',  
      [
        ['сыр', 50, 'гр.'],
        ['томаты', 50, 'гр.'],
        ['тесто', 100, 'гр.'],
        ['бекон', 30, 'гр.'],
        ['колбаса', 30, 'гр.'],
        ['грибы', 20, 'гр.'],
      ],
  ],
  ['фруктовый десерт',
      [
        ['хурма', 60, 'гр.'],
        ['киви', 60, 'гр.'],
        ['творог', 60, 'гр.'],
        ['сахар', 10, 'гр.'],
        ['мед', 50, 'мл.'],  
      ]
  ]
]

person = 5

for deash in cook_book:
    print(f'{deash[0]}:')
    
    for item in deash[1]:
        print(f'{item[0]}, {int(item[1]*person)}{item[2]}')
```
