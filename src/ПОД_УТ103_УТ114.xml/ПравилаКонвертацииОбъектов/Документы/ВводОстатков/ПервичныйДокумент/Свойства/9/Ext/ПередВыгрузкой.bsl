﻿Если ЗначениеЗаполнено(Источник.ПорядокРасчетов) Тогда
	Значение = Источник.ПорядокРасчетов;
ИначеЕсли ЗначениеЗаполнено(Источник.Договор) Тогда
	Значение = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Источник.Договор, "ВедениеВзаиморасчетов");
	ИмяПКО = "ВедениеВзаиморасчетовПоДоговорам_ПорядокРасчетов";
Иначе
	Значение = "ПоНакладным";
КонецЕсли;
