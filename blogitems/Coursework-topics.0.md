title: Coursework topics (Курсовые)
authors: kakadu <kakadu@protonmail.ch>
date: 2018-03-14T12:46:53-00:00
uuid: c0615a9d-3844-4b56-91cc-4b1968ddd7ab

There some topics to research or projects to do that I can't perform because I'm too lazy, don't have enough time or energy to finish or something like. That's why it's good to outsource them to students :) I expect that most people reading it will ne native russians I will sometimes use appropriate language below.

MiniKanren stuff
===============

[MiniKanren](http://minikanren.org) -- это такой реляционный (похож на логический) язык программирования, на котором удобно писать переборные задачи, например, породить заданное количесво программ, которые редуцируются (вычисляются) сами в себя (так называемые квайны). Фишкой подхода является не написания перебора в лоб, а написания реляционного интерпретатора, который принимает программу и вычисляет её, а затем запуске этого интерпретатора в обратную сторону: зафиксировав (не совсем точно сказано, но если углубиться, то станет понятно, что происходит) результат интерпретации, получим все программы, которые дают такой ответ. Такой синтез программ можно найти в репозитории [Barliman](https://github.com/webyrd/Barliman), там же в README ссылка на ютюбик


В данный момент miniKanren это скорее научное исследование, чем практически полезный язык программирования, что, однако не помешало ему прижиться в Clojure.

Сейчас Barliman написан на Cocoa и запускается только на Mac'е. Надо сделать кроссплатформенную поделку. Пока планируется Qt/QML.


Свалка
======

Вот какая-то [презентация](http://kakadu.github.io/mm/presentation.pdf) где давал три темы третьекурсникам, но никто не взялся.
