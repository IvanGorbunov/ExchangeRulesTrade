﻿
// Если номенклатура имеет характеристики, используем расширенные правила конвертации вида номенклатуры
// Наименование вида номенклатуры - наименование из Объекта назначения.
// Тип номенклатуры - из вида номенклатуры источника.
// Использование характеристик = Истина;
// Набор свойств номенклатуры - Создаем новый набор свойств через список свойств
// Набор свойств характеристик - Создаем новый набор свойств через список свойств

// Если номенклатура не имеет характеристик - то конвертируем стандартным способом

Если Не Источник.ЭтоГруппа Тогда
	
	СоздатьВидНоменклатуры_Номенклатура                 = Источник.Ссылка;
	СоздатьВидНоменклатуры_НаименованиеВидаНоменклатуры = Источник.ВидНоменклатуры.Наименование;
	СоздатьВидНоменклатуры_ТипНоменклатуры              = Источник.ВидНоменклатуры.ТипНоменклатуры;
	СоздатьВидНоменклатуры_ИспользоватьСерии            = Источник.ВестиУчетПоСериям И Параметры.РежимВыгрузкиСерий > 0;
	СоздатьВидНоменклатуры_ТипНоменклатуры              = ВходящиеДанные.ТипНоменклатуры;
	СоздатьВидНоменклатуры_ИмпортнаяАлкогольнаяПродукция = ВходящиеДанные.АлкогольнаяПродукция И ВходящиеДанные.ВестиУчетПоГТД;
	СоздатьВидНоменклатуры_АлкогольнаяПродукция          = ВходящиеДанные.АлкогольнаяПродукция;
	СоздатьВидНоменклатуры_ВидАлкогольнойПродукции       = ВходящиеДанные.ВидАлкогольнойПродукции;
	Выполнить(Алгоритмы.СоздатьВидНоменклатуры);
	
КонецЕсли;
