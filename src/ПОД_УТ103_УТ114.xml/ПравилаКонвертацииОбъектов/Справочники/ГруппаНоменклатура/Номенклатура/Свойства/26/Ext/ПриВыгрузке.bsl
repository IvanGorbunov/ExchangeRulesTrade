﻿Если ЗначениеЗаполнено(Значение) Тогда
	Если ЗначениеЗаполнено(Источник.ЕдиницаХраненияОстатков) И Источник.ЕдиницаХраненияОстатков.Коэффициент <> 0 Тогда
		Значение = Значение.Коэффициент / Источник.ЕдиницаХраненияОстатков.Коэффициент;
	Иначе
		Значение = Значение.Коэффициент;
	КонецЕсли;	
Иначе
	Значение = 1;
КонецЕсли;
