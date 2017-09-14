# Валидация контейнера

После того как все регистрации компонентов были произведены, стоит проверить - а все ли правильно. При этом стоит учитывать тот факт - что если при одном и томже коде один раз все было правильно, то нету никаких причин чтобы второй раз был не правильно. Поэтому была создана отдельная функция валидации графа, которую я настоятельно рекомендую запускать только в debug, и не запускать в release - дабы сэкономить время запуска программы. В идеале ее стоит запускать после каждого изменения в DI, но такую проверку сложно реализовать.

## Синтаксис
Чтобы провалидировать граф зависимостей достаточно у контейнера после всех регистраций, вызвать метод `valid()`:
```Swift
if !container.valid() {
  fatalError("you has errors")
}
```
Я настоятельно рекомендую использовать препроцесс директории, или другие способы принятые у вас в проекте, и писать код на подобии:
```Swift
#if DEBUG
  if !container.valid() {
    fatalError("you has errors")
  }
#endif
```

Чтобы узнать какие именно ошибки есть, стоит использовать логгер о котором написано в следующих главах.

## Что проверяется?
Процесс валидации поделен на две большие части:
* Валидация возможности внедрений
* Проверка циклов

В первой части происходит полная проверка графа, на то, что в любой объект можно внедрить все зависимости указанные в нем. Если зависимость внедряется как опционал, то в случае не возможности ее внедрения будет написано только предупреждение. Но если зависимости не опциональная, и не удалось найти для нее компонента, то об этом будет написано, причем в нескольких вариантов: Полность не удалось найти; объекты существуют, но у них нету метода инициализации; Слишком много вариантов компонент, которые могут выступать для создания объекта.

Во второй части, находятся все циклы, и каждый цикл проверяется, на его возможность, то есть:
* Цикл не состоит полностью из методов инициализации 
* Цикл имеет хотябы одну точку разрыва. При этом если в цикле есть внедрение множества объектов через метод инициализации то это также является точкой разрыва, и не является полноценным методом инициализации
* Цикл полностью состоит из `prototype` - такой цикл точно не сможет создасться
* Цикл имеет `prototype` - это только предупреждение, но настоятельно рекомендую подумать прежде чем закрывать на него глаза.

В любом случае советую просматривать к предупреждения - они могут ошибаться, но в большинстве случаев к ним стоит прислушаться.

#### [Главная](main.md)
#### [Предыдущая глава "Внедрение"](injection.md#Внедрение)
#### [Следующая глава "Разрешение зависимостей"](resolve.md#Разрешение-зависимостей)