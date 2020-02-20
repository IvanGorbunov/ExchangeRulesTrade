﻿Запрос = Новый Запрос("
|ВЫБРАТЬ
|	ПартииТоваровНаСкладахОстатки.ДокументОприходования.ДоговорКонтрагента КАК ДоговорКонтрагента,
|	ПартииТоваровНаСкладахОстатки.ДокументОприходования.Контрагент         КАК Контрагент,
|	
|	ПартииТоваровНаСкладахОстатки.Номенклатура               КАК Номенклатура,
|	ПартииТоваровНаСкладахОстатки.ХарактеристикаНоменклатуры КАК Характеристика,
|
|	ВЫБОР КОГДА ЕСТЬNULL(СУММА(ПартииТоваровНаСкладахОстатки.КоличествоОстаток),0) <> 0 ТОГДА 
|		ВЫРАЗИТЬ(СУММА(ПартииТоваровНаСкладахОстатки.СтоимостьОстаток) / СУММА(ПартииТоваровНаСкладахОстатки.КоличествоОстаток) КАК Число(15,2))
|	ИНАЧЕ
|	0
|	КОНЕЦ КАК Цена
|ИЗ
|	РегистрНакопления.ПартииТоваровНаСкладах.Остатки(
|			&ДатаОстатков,
|			СтатусПартии = ЗНАЧЕНИЕ(Перечисление.СтатусыПартийТоваров.НаКомиссию)
|				И Номенклатура.ВидНоменклатуры.ТипНоменклатуры = ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар)) КАК ПартииТоваровНаСкладахОстатки
|
|СГРУППИРОВАТЬ ПО
|	ПартииТоваровНаСкладахОстатки.Номенклатура,
|	ПартииТоваровНаСкладахОстатки.ХарактеристикаНоменклатуры,
|	ПартииТоваровНаСкладахОстатки.ДокументОприходования.Контрагент,
|	ПартииТоваровНаСкладахОстатки.ДокументОприходования.ДоговорКонтрагента
|ИТОГИ ПО
|	ПартииТоваровНаСкладахОстатки.ДокументОприходования.Контрагент,
|	ПартииТоваровНаСкладахОстатки.ДокументОприходования.ДоговорКонтрагента
|");

ВыборкаДанных = Новый ТаблицаЗначений;
ВыборкаДанных.Колонки.Добавить("Дата");
ВыборкаДанных.Колонки.Добавить("Проведен");
ВыборкаДанных.Колонки.Добавить("ПометкаУдаления");
ВыборкаДанных.Колонки.Добавить("Ответственный");
ВыборкаДанных.Колонки.Добавить("Комментарий");

ВыборкаДанных.Колонки.Добавить("Партнер");
ВыборкаДанных.Колонки.Добавить("Соглашение");

ВыборкаДанных.Колонки.Добавить("Товары");

Запрос.УстановитьПараметр("ДатаОстатков", КонецДня(Параметры.ДатаОстатков));


РезультатыЗапроса = Запрос.Выполнить();
ВыборкаПоКонтрагентам = РезультатыЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
Пока ВыборкаПоКонтрагентам.Следующий() Цикл
	
	ВыборкаПоДоговорамКонтрагента = ВыборкаПоКонтрагентам.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаПоДоговорамКонтрагента.Следующий() Цикл
		
		НоваяСтрока = ВыборкаДанных.Добавить();
		НоваяСтрока.Дата            = НачалоДня(Параметры.ДатаОстатков); 
		НоваяСтрока.Проведен        = Истина; 
		НоваяСтрока.ПометкаУдаления = Ложь; 
		НоваяСтрока.Комментарий     = "УТ103 -> УТ11: Цены комитента по остаткам партий товаров на складах"; 
		
		НоваяСтрока.Партнер    = ВыборкаПоКонтрагентам.Контрагент; 
		НоваяСтрока.Соглашение = ВыборкаПоДоговорамКонтрагента.ДоговорКонтрагента; 
		
		НоваяСтрока.Товары = Новый ТаблицаЗначений;
		НоваяСтрока.Товары.Колонки.Добавить("Номенклатура");
		НоваяСтрока.Товары.Колонки.Добавить("Характеристика");
		НоваяСтрока.Товары.Колонки.Добавить("Упаковка");
		НоваяСтрока.Товары.Колонки.Добавить("Цена");
		
		ВыборкаПоДетальнымЗаписям = ВыборкаПоДоговорамКонтрагента.Выбрать();
		Пока ВыборкаПоДетальнымЗаписям.Следующий() Цикл
			
			НоваяСтрокаТовары = НоваяСтрока.Товары.Добавить();
			НоваяСтрокаТовары.Номенклатура               = ВыборкаПоДетальнымЗаписям.Номенклатура; 
			НоваяСтрокаТовары.Характеристика             = ВыборкаПоДетальнымЗаписям.Характеристика; 
			НоваяСтрокаТовары.Цена                       = ВыборкаПоДетальнымЗаписям.Цена; 
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецЦикла;
