﻿ИсходящиеДанные = Новый Структура;
Если Параметры.ИспользоватьХарактеристикиНоменклатуры
	И ОбъектКоллекции.Номенклатура.ВестиУчетПоХарактеристикам
	И НЕ ЗначениеЗаполнено(ОбъектКоллекции.Характеристика) Тогда
	ИсходящиеДанные.Вставить("Владелец", ОбъектКоллекции.Номенклатура);
	Значение = Новый Структура("Ссылка");
	ИмяПКО = "ПустаяХарактеристикаНоменклатуры";
КонецЕсли;
