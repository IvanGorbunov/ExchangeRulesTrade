﻿ИсходящиеДанные = Новый Структура;
Если ЗначениеЗаполнено(ОбъектКоллекции.Качество) И ОбъектКоллекции.Качество <> Справочники.Качество.Новый Тогда
	ИсходящиеДанные.Вставить("Качество", ОбъектКоллекции.Качество);
	ИмяПКО = "НекачественнаяНоменклатура";
КонецЕсли;
