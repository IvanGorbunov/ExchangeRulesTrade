﻿Выполнить(Алгоритмы.УстановитьОтветственногоВДокумент);
Объект.НалогообложениеНДС = УчетНДСУП.ПараметрыУчетаПоОрганизации(Объект.Организация, ТекущаяДата(), Неопределено).ОсновноеНалогообложениеНДСПродажи;
Объект.Валюта = Константы.ВалютаУправленческогоУчета.Получить();
Параметры.ДокументыДляПроведения.Добавить(Объект);
