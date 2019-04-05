#language: ru

Функциональность: Объединение шаблонов кода

Как разработчик
Я хочу получить единый файл шаблона кода
Чтоб проще распространять и подключать его

Контекст:
	Допустим Я очищаю параметры команды "oscript" в контексте 
		И я включаю отладку лога с именем "oscript.app.snippet-transform"
		И я создаю временный каталог и сохраняю его в контекст
		И я устанавливаю временный каталог как рабочий каталог
		И я установил рабочий каталог как текущий каталог
		И я создаю каталог "snippets" в рабочем каталоге
		И я копирую файл "ШаблонКонфигуратора.st" из каталога "tests/fixtures//snippets" проекта в подкаталог "snippets" рабочего каталога
		И я копирую файл "ШаблонEDT.xml" из каталога "tests/fixtures//snippets" проекта в подкаталог "snippets" рабочего каталога

Сценарий: Объединение двух шаблонов
	Когда я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os join-files snippets/ШаблонКонфигуратора.st snippets/ШаблонEDT.xml"
	Тогда Код возврата равен 0
		И Файл "snippets/ШаблонКонфигуратора.st" в рабочем каталоге содержит 
		""" 
		{"Общий модуль",0,0,"Модуль[Общий]","//⇗ ⇘ ⇙ ⇚ ⇛ ⇜ ⇝ ⇞ ⇟ ⇠ ⇡ ⇢ ⇣ ⇤ ⇥ ⇦ ⇧ ⇨ ⇩ ⇪ ⇫ ⇬ ⇭ ⇮ ⇯ ⇰ ⇱ ⇲ ⇳ ⇴ ⇵ ⇶ ⇷ ⇸ ⇹ ⇺ //
		"""
		И Файл "snippets/ШаблонКонфигуратора.st" в рабочем каталоге содержит 
		""" 
		ТекущаяДата = '<?"n1", ДатаВремя, ""ДФ=dd.MM.yyyy"">'
		"""
