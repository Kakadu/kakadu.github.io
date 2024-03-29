---
layout: post
title: "Курсовые работы для ИТМО/ВШЭ"
date: 2024-02-28
categories: teaching
---

Попросили выбрать некоторые темы, которые можно дать студентам ИТМО/ВШЭ.
Вот те, по которым более всего хотелось бы увидеть какой-то прогресс, но полный список можно найти тут:
[https://kakadu.github.io/2024/topics](https://kakadu.github.io/2024/topics).

Вопросы и просьбы описать тему более подробно засылать в [Telegram](https://t.me/Kakadu18).

{: #ocaml-linter }

## OCaml linter (a.k.a. zanuda)

Код на языках прораммирования можно пытаться проверять разными способами и утилитами. Те проверки, которые не делает компилятор часто реализуют с помощью так называемых "линтеров".
Для функционального языка программирования OCaml на языке OCaml мною [написан](https://github.com/kakadu/zanuda) такой линтер, он применяется для проверки домашних заданий обучающихся на 2м курсе направления ПИ матмеха СПбГУ.

Сейчас он кое-что умеет, но есть куда развиваться.
Есть небольшое количество инфраструктурных [задач](https://github.com/Kakadu/zanuda/issues/23),
а также [большое количество](https://github.com/Kakadu/zanuda/issues/3) проверок ("линтов"), которые пока не реализованы.
Хватит более чем на одного человека.

**Пожелания**. Если уже сдавали какой-то курс по функциональному программированию (OCaml, Haskell, Scala, F#), то вам будет гораздо легче. Если нет -- весьма тяжело.

**Требования**. Научиться [проект](https://github.com/kakadu/zanuda) компилировать и запускать, перед приходом ко мне.




{: #ocaml-qml }

## OCaml + Qt/QML

Тема про улучшение проектирование графических интерфейсов для языка OCaml. Подробнее [здесь](https://kakadu.github.io/2024/topics#ocaml-qml).

Можно выделить две относительно понятные задачи

* Доработать поддержку Qt6 в [lablqml](https://github.com/Kakadu/lablqml/issues/70).
* Научиться вызывать сигналы/слоты объектов Qt без применения порождения кода во время компиляции.
  Это сейчас [частично сделано](https://github.com/mikhaylovilya/ocaml-syntax-extension) в рамках [учебных практик](https://se.math.spbu.ru/thesis_download?thesis_id=1234) с некоторыми ограничениями.
  В процессе хочется эти ограничения снять и сделать лучше.

Обе задачи скорее на ознакомление с фреймворком Qt, чем про OCaml.

**Пожелания**. Желательно, чтобы вы Qt/QML до этого видели.

**Требования**. Без знакомства с С++ будет тяжело.

<script>for(let h of document.querySelectorAll('h2[id],h3[id],h4[id]'))h.innerHTML+=` <a href="#${h.id}" aria-hidden="true">#</a>`</script>
