///////////////////////////////////////////////////////////////////
//
// Тестирование основной функциональности пакета
// Проверка на соответствие выгрузки эталону
//
// (с) BIA Technologies, LLC
//
///////////////////////////////////////////////////////////////////

#Использовать asserts
#Использовать tempfiles

///////////////////////////////////////////////////////////////////

Перем МенеджерВременныхФайлов;

///////////////////////////////////////////////////////////////////
// Программный интерфейс
///////////////////////////////////////////////////////////////////

Функция ПолучитьСписокТестов(Знач ЮнитТестирование) Экспорт

	МассивТестов = Новый Массив;
	МассивТестов.Добавить("ТестПрочитатьШаблон");
	МассивТестов.Добавить("ТестЗаписатьШаблон");
	МассивТестов.Добавить("ТестПрочитатьИЗаписатьШаблон");

	Возврат МассивТестов;

КонецФункции

Процедура ПередЗапускомТеста() Экспорт

	МенеджерВременныхФайлов = Новый МенеджерВременныхФайлов;

КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт

	МенеджерВременныхФайлов.Удалить();

КонецПроцедуры

///////////////////////////////////////////////////////////////////
// Шаги
///////////////////////////////////////////////////////////////////

Процедура ТестПрочитатьШаблон() Экспорт

	Шаблон = ШаблоныКонфигуратора.ПрочитатьШаблон(ОбъединитьПути(КаталогФикстур(), "snippets", "ШаблонКонфигуратора.st"));

	Утверждения.ПроверитьРавенство(Шаблон.Элементы.Количество(), 3, "Количество элементов шаблона равно 3");

КонецПроцедуры

Процедура ТестЗаписатьШаблон() Экспорт

	Шаблон = ШаблоныБазовый.КорневойЭлемент();
	
	Группа = ШаблоныБазовый.Группа();
	Группа.Наименование = "Группа";
	Шаблон.Элементы.Добавить(Группа);

	Элемент = ШаблоныБазовый.Элемент();
	Элемент.Наименование = "Сообщить";
	Элемент.ТекстЗамены = "Соо[бщить]";
	Элемент.Шаблон = "Сообщить();";
	Шаблон.Элементы.Добавить(Элемент);

	Элемент = ШаблоныБазовый.Элемент();
	Элемент.Наименование = "Сообщить2";
	Элемент.ТекстЗамены = "Соо[бщить2]";
	Элемент.Шаблон = "Сообщить(2);";
	Группа.Элементы.Добавить(Элемент);

	ИмяФайла = МенеджерВременныхФайлов.НовоеИмяФайла("st");
	ШаблоныКонфигуратора.ЗаписатьШаблон(Шаблон, ИмяФайла);

	ТекстФайла = ПрочитатьФайл(ИмяФайла);

	Эталон =
	"{1,
	|{2,
	|{""Корень"",1,0,"""",""""},
	|{1,
	|{""Группа"",1,0,"""",""""},
	|{0,
	|{""Сообщить2"",0,0,""Соо[бщить2]"",""Сообщить(2);""}
	|}
	|},
	|{0,
	|{""Сообщить"",0,0,""Соо[бщить]"",""Сообщить();""}
	|}
	|}
	|}";
	Утверждения.ПроверитьРавенство(ТекстФайла, Эталон, "Текст шаблона не соответствует ожидаемому");

КонецПроцедуры

Процедура ТестПрочитатьИЗаписатьШаблон() Экспорт

	ИмяБазовогоШаблона = ОбъединитьПути(КаталогФикстур(), "snippets", "ШаблонКонфигуратора.st");
	ИмяНовогоШаблона = МенеджерВременныхФайлов.НовоеИмяФайла("st");

	Шаблон = ШаблоныКонфигуратора.ПрочитатьШаблон(ИмяБазовогоШаблона);

	ШаблоныКонфигуратора.ЗаписатьШаблон(Шаблон, ИмяНовогоШаблона);

	Утверждения.ПроверитьРавенство(ПрочитатьФайл(ИмяБазовогоШаблона), ПрочитатьФайл(ИмяНовогоШаблона), "Текст шаблона не должен измениться");

КонецПроцедуры

///////////////////////////////////////////////////////////////////
// Служебный функционал
///////////////////////////////////////////////////////////////////

Функция КаталогФикстур()

	Возврат ОбъединитьПути(ТекущийСценарий().Каталог, "..", "tests", "fixtures");

КонецФункции

Функция ПрочитатьФайл(Файл)

	Чтение = Новый ЧтениеТекста(Файл, КодировкаТекста.UTF8NoBOM);
	Текст = Чтение.Прочитать();
	Чтение.Закрыть();

	Возврат Текст;

КонецФункции
