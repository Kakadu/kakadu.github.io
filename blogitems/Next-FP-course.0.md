Title: Next FP course
Authors: kakadu <kakadu@protonmail.ch>
Date: 2018-03-04T14:39:22-00:00
ID: c0615a9d-3844-4b56-91cc-4b1968ddd7ad
Categories: listed, published

---

Talk by Yaron Minsky 
(https://www.youtube.com/watch?v=0arFPIQatCU)[`Types, and Why You Should Care`]

В языки программирования сложно выбрать лучший, потому что наука никак не помогает
это сделать. Краткосрочные семестровые исследования на второкурсниках не показательны,
потому что тут важно как язык себя ведет на большом промежутке времени, а ни одного 
студента 
нельзя найти с лозунгом "давайте вы следующие 6 лет будете программировать на COBOL".
А в течение семестрового курса ничего нельзя понять, не существует достаточно толстой 
пачки студентов-второкурсников, чтобы получилось хорошее исследование

Слайд с двумя колонками (типизированные языки и нетипизированные)

Вот списки языков, от более популярных вних к менее известным. В правой колонки 
динамические языки, которые ещё иногда называют интерпретируемыми. Они порой не очень 
быстрые (от 10 до 100 раз). Левые часто называют более сложными, в том смысле что
с ними сложнее работать, вернее дольше писать какой-то минимальный helloworld, иногда 
код на них подлиннее, иногда, чересчур хитромудрые

Some vocabulary
values -- данные, которые текут по прграмме, числа, списки, функции.
variable -- почти как значение, но не совсем то же самое. Когда мы видим, в программе
`x=3` это означает что в этот момент в икс хранится значение три, и икс это получается
имя для значения, но в разные моменты времени в этом иксе могут храниться разные 
значения. Когда функция дергается от икс, всякий раз икс может быть разный, функции
могут менять значения и результаты будут изменяться. Т.е значения более статические
чем переменные, они зависят от того, что изначально было написано в программе, они
это часть лексической состаявляющей программы.

expressions
Можно думать, что выражения это такая одноуровневая надстройка над перменными, можем 
иметб переменную икс, и уметь строить икс _  плюс игрек, типа более общаю штука, которая
позволяет строить большие программы

Типы
О них можно думать, как о штуке для категризирования значений, сходные значения 
попадают в один и тот же тип. Например, string, int и float это примеры типов.

Разница между типизированным и нетипизированным языком в том, что в нетип. только 
значения имеют тип, а в типизированном и данные, и переменные, и выражения имеют тип.
Почему типизированные программы, часто называют статически типизированныеми, потому
что статическая часть прораммы (код который написали) имеет типы в себе и они не меняются
во время исполнения . Отдельные переменные имеют тип, а также большие выражения тоже имеют 
тип. Например, если икс это флоат, то икс плюс игрек тоже имеет тип флоат

Зачем типы?
История ведет отсчет и 50х когда появились фортран и Лисп. Первым назначением типов было
сделать, чтобы программы работали быстро. Например, если вы на Питоне складываете две
переменные вместе, то надо рассмотреть некоторое количество случаем. Если складываем два 
целых числа, то надо сделать сложение целых чисел; если складывает 3.5 и 6.2, то сложение 
флоатов;
если складываем две строки, то надо IIRC сделать конкатенцию (тут шутка про то, что это
сепер странно и явная ошибка, смех в зале). Много разного происходит в интерпретаторе в 
зависимости от выданных данных (оверхед). А цикл интерпретатора должен произвести 
некоторую работу по распознавание чего ему пришло, и это замедлит всё раз в 10 или 100. 
Если в типах мы знаем, что есть два числа, то мы можем это скомпилировать в одну машинную 
инструкцию. Короче в типизированных языках лучше производительность, потому что они 
позволяют компиляторы генерировать более эффективный код, чем тот , который может быть
сгенерирован в динамических. Однако, в динамических языках была проделана большая работа
по оптимизированию, чтобы они не отставали на видимую дистанцию от типизированных языков
(javascript может тормозить раза в три сильнее), но даже если и так, что это гораздо
менее предсказыемо. Например, мы можем поменять одну строчку каким-то образом так, что 
V8 это не понравится и оно будет работать 10 раз медленнее чем было. Взять что-то в 
динамически типизируемом языке и заставить работать быстро, это может оказаться 
очень сложной задачей. Например, брать трассирующий компилятор и добавлять эвристики
типа "в этом случае у меня скорее всего всегда два числа, так что давай здесь поставим 
сложение для целых чисел". Но это такие, очень шаткие оптимизации.
Короче вопрос в производительности и предсказуемой производительности

Второе аспект в том, что типы позволяют делать программу понимаемой, а именно для людей
: для тебя и для людей которые работают с тобой 

Всё это выглядит как клёвые штуки, так почему народу не нравятся типы? Почему они не 
используются повсеместно. Ну, потому что есть некоторые недостатки. Сейчас поговорим,
что за недостатки и откуда они берутся.

Очень часто, программы на типизированных языках горзадо более многословные, чем программы 
на интерпретируемых языках. 

Пример: скучная Питоновская функция
> def truncate\_with\_ramainder(x):
>    intpart = int(x)
>    return (intpart, x-intpart)

Она берет вход в переменной икс (которая по плану должна хранить флоат) и возвращает 
пару из целого числа и дробной части

Теперь то же на Java образца 1995 года.
Это ужасно, не правда ли? Нифига не понятно, почему столько мусора на экране. А всё 
потому что в Java не было встроенного понятия пары. Даже generic класса тогда не было,
потому надо было сотворить новый класс, для результата из двух штук, и потому породить
конструкторы, геттеры, ой, убейте меня уже. Этот мусор очень мешает программировать в
лаконичной манере. Java теперь лучше, мы не имеем это проблему в такой же степени 
ужасностив наши дни.

Теперь тут есть дженерики, способ, который позволяет выразить это, тут пояыляется 
понятие переменной типа, которая означает что тип ещё не полностью специализирован.
До появления женериков надо было указывать тип, и те штуки которые в нём лежат 
и образуют его, так что не получалось описать пару общего назначения.
Но с женериками всё гораздо удобнее чем было до этого.

Так в чем суть этого примера? То, сколько лишнего текста заставляет теб янаписать 
статическая система типов тесно связано с тем, на сколько она выразителен язык
типов.  Типы позволяют встроить некотрую структуру, позволяют сказать что-то 
о программе, описать некоторые аспекты именно вашей программы а не других
, и когда они не позволяют описать всё это в естесственной манере, то вы часто
скатывается к выражению этого в неестественной манере, и это часто заставляет 
писать много лишнего текста. Т.е. наличие достаточно выразительного языка 
позволяет кое-как решить проблему краткости. Важно упомянуть некоторые другие 
вещи, которые вы можете сделать. Вот реализация на OCaml и если вы сравните
её с Питоном, то они будут очень похожи (одинакоые) и если мы сравним это с Java
(новой версией), то всё равно будет куча штук, которые отвлекают нас от того, что
происходит. Вот другой вид краткости, который можете получить от типизированного 
языка: не нужно писать все эти аннотации везде, и технология, которая позволяет
это делать называет выводом типов, т.е. в языке, напрмер, OCaml, вместо того, 
чтобы писать аннотации у каждой переменной, типы могут быть выведены компилятором.

(Тут мне стало лень констпектировать)

-- 
Talk by Yaron Minsky 
(https://www.youtube.com/watch?v=_1GZShA1F20)[`Observations of a Functional Programmer`]

