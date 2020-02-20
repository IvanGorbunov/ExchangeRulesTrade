﻿Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	&ДатаОстатков КАК ДатаПлатежа,
	|	ВзаиморасчетыСКонтрагентамиОстатки.Организация КАК Организация,
	|	ВзаиморасчетыСКонтрагентамиОстатки.Сделка КАК Сделка,
	|	ВзаиморасчетыСКонтрагентамиОстатки.Контрагент КАК Контрагент,
	|	ВзаиморасчетыСКонтрагентамиОстатки.Контрагент КАК Партнер,
	|	ВзаиморасчетыСКонтрагентамиОстатки.СуммаВзаиморасчетовОстаток КАК Сумма,
	|	ВзаиморасчетыСКонтрагентамиОстатки.ДоговорКонтрагента.ВалютаВзаиморасчетов КАК ВалютаВзаиморасчетов,
	|	ВзаиморасчетыСКонтрагентамиОстатки.ДоговорКонтрагента КАК РасчетныйДокумент,
	|	ВЫБОР
	|		КОГДА ВзаиморасчетыСКонтрагентамиОстатки.ДоговорКонтрагента.Номер = """"
	|			ТОГДА ВзаиморасчетыСКонтрагентамиОстатки.ДоговорКонтрагента.Код
	|		ИНАЧЕ ВзаиморасчетыСКонтрагентамиОстатки.ДоговорКонтрагента.Номер
	|	КОНЕЦ КАК НомерРасчетногоДокумента,
	|	ВЫБОР
	|		КОГДА ВзаиморасчетыСКонтрагентамиОстатки.ДоговорКонтрагента.Дата = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА &ДатаОстатков
	|		ИНАЧЕ ВзаиморасчетыСКонтрагентамиОстатки.ДоговорКонтрагента.Дата
	|	КОНЕЦ КАК ДатаРасчетногоДокумента
	|ПОМЕСТИТЬ ОстаткиВзаиморасчетов
	|ИЗ
	|	РегистрНакопления.ВзаиморасчетыСКонтрагентами.Остатки(
	|			&ДатаОстатков,
	|			ДоговорКонтрагента.ВидДоговора = ЗНАЧЕНИЕ(Перечисление.ВидыДоговоровКонтрагентов.СКомиссионером)
	|				И (НЕ ДоговорКонтрагента.ВестиПоДокументамРасчетовСКонтрагентом)) КАК ВзаиморасчетыСКонтрагентамиОстатки
	|ГДЕ
	|	ВзаиморасчетыСКонтрагентамиОстатки.СуммаВзаиморасчетовОстаток > 0
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ
	|	&ДатаОстатков,
	|	ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.Организация,
	|	ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.Сделка,
	|	ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.Контрагент,
	|	ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.Контрагент,
	|	ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.СуммаВзаиморасчетовОстаток,
	|	ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.ДоговорКонтрагента.ВалютаВзаиморасчетов,
	|	ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.ДоговорКонтрагента,
	|	ВЫБОР
	|		КОГДА ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.ДоговорКонтрагента.Номер = """"
	|			ТОГДА ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.ДоговорКонтрагента.Код
	|		ИНАЧЕ ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.ДоговорКонтрагента.Номер
	|	КОНЕЦ,
	|	ВЫБОР
	|		КОГДА ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.ДоговорКонтрагента.Дата = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА &ДатаОстатков
	|		ИНАЧЕ ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.ДоговорКонтрагента.Дата
	|	КОНЕЦ
	|ИЗ
	|	РегистрНакопления.ВзаиморасчетыСКонтрагентамиПоДокументамРасчетов.Остатки(
	|			&ДатаОстатков,
	|			ДоговорКонтрагента.ВидДоговора = ЗНАЧЕНИЕ(Перечисление.ВидыДоговоровКонтрагентов.СКомиссионером)
	|				И УпрУчет
	|				И ((НЕ ДокументРасчетовСКонтрагентом ССЫЛКА Документ.ОтчетКомиссионераОПродажах)
	|					ИЛИ ДоговорКонтрагента.ВедениеВзаиморасчетов = ЗНАЧЕНИЕ(Перечисление.ВедениеВзаиморасчетовПоДоговорам.ПоДоговоруВЦелом))) КАК ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки
	|ГДЕ
	|	ВзаиморасчетыСКонтрагентамиПоДокументамРасчетовОстатки.СуммаВзаиморасчетовОстаток > 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОстаткиВзаиморасчетов.ДатаПлатежа,
	|	ОстаткиВзаиморасчетов.Организация                    КАК Организация,
	|	ОстаткиВзаиморасчетов.Контрагент                     КАК Контрагент,
	|	ОстаткиВзаиморасчетов.Партнер,
	|	СУММА(ОстаткиВзаиморасчетов.Сумма)                   КАК Сумма,
	|	
	|	СУММА(ОстаткиВзаиморасчетов.Сумма * ВЫБОР
	|		КОГДА ЕСТЬNULL(КурсыВалют.Курс, 0) > 0
	|				И ЕСТЬNULL(КурсыВалют.Кратность, 0) > 0
	|			ТОГДА КурсыВалют.Курс / КурсыВалют.Кратность
	|		ИНАЧЕ 0
	|	КОНЕЦ)                                               КАК СуммаРегл,
	|	
	|	ОстаткиВзаиморасчетов.ВалютаВзаиморасчетов,
	|	ОстаткиВзаиморасчетов.РасчетныйДокумент КАК ОбъектРасчетов,
	|	ОстаткиВзаиморасчетов.НомерРасчетногоДокумента,
	|	ОстаткиВзаиморасчетов.ДатаРасчетногоДокумента
	|ИЗ
	|	ОстаткиВзаиморасчетов КАК ОстаткиВзаиморасчетов
	|	
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних(&ДатаОстатков) КАК КурсыВалют
	|		ПО ОстаткиВзаиморасчетов.ВалютаВзаиморасчетов = КурсыВалют.Валюта
	|	
	|
	|СГРУППИРОВАТЬ ПО
	|	ОстаткиВзаиморасчетов.ДатаПлатежа,
	|	ОстаткиВзаиморасчетов.Организация,
	|	ОстаткиВзаиморасчетов.Контрагент,
	|	ОстаткиВзаиморасчетов.Партнер,
	|	ОстаткиВзаиморасчетов.ВалютаВзаиморасчетов,
	|	ОстаткиВзаиморасчетов.РасчетныйДокумент,
	|	ОстаткиВзаиморасчетов.НомерРасчетногоДокумента,
	|	ОстаткиВзаиморасчетов.ДатаРасчетногоДокумента
	|
	|УПОРЯДОЧИТЬ ПО
	|	Контрагент
	|ИТОГИ ПО
	|	Организация
	|АВТОУПОРЯДОЧИВАНИЕ");
	
Если Параметры.Организации.Количество() > 0 Тогда
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ДоговорКонтрагента.ВидДоговора = ЗНАЧЕНИЕ", 
								"Организация В (&МассивОрганизаций) И ДоговорКонтрагента.ВидДоговора = ЗНАЧЕНИЕ");
	Запрос.УстановитьПараметр("МассивОрганизаций", Параметры.Организации);
КонецЕсли;	

Запрос.УстановитьПараметр("ДатаОстатков", КонецДня(Параметры.ДатаОстатков));

ВыборкаДанных = Новый ТаблицаЗначений;
ВыборкаДанных.Колонки.Добавить("Дата");
ВыборкаДанных.Колонки.Добавить("Организация");
ВыборкаДанных.Колонки.Добавить("РасчетыСПартнерами");

РезультатыЗапроса = Запрос.Выполнить();
ВыборкаПоОрганизациям = РезультатыЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
Пока ВыборкаПоОрганизациям.Следующий() Цикл
	
	НоваяСтрока = ВыборкаДанных.Добавить();
	НоваяСтрока.Дата        = КонецДня(Параметры.ДатаОстатков); 
	НоваяСтрока.Организация = ВыборкаПоОрганизациям.Организация; 
	
	РасчетыСПартнерами = Неопределено;
	Выполнить(Алгоритмы.ТаблицаРасчетовСПартнерами);
	НоваяСтрока.РасчетыСПартнерами = РасчетыСПартнерами;
	
	ВыборкаДетальныеЗаписи = ВыборкаПоОрганизациям.Выбрать(); 
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НоваяСтрокаРасчетыСПартнерами = НоваяСтрока.РасчетыСПартнерами.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрокаРасчетыСПартнерами, ВыборкаДетальныеЗаписи);
		НоваяСтрокаРасчетыСПартнерами.СуммаУпр = МодульВалютногоУчета.ПересчитатьИзВалютыВВалюту(ВыборкаДетальныеЗаписи.СуммаРегл,
			Параметры.ВалютаРеглУчета, Параметры.ВалютаУпрУчета, 1, Параметры.КурсВУУ.Курс, 1, Параметры.КурсВУУ.Кратность);
	КонецЦикла;
	
КонецЦикла;
	
Выполнить(Алгоритмы.ОчисткаВыборки);
