import Foundation

struct Topic: Codable, Identifiable {
    let id: UUID
    let name: String
    let questions: [Question]
    let isCompleted: Bool
    
    var toDataModel: TopicDataModel {
        TopicDataModel(
            id: id,
            name: name,
            questions: questions.map(\.toDataModel),
            isCompleted: isCompleted
        )
    }
}

#if DEBUG
extension Topic {
    static let testDataPython: [Topic] = [
        Topic(
            id: UUID(),
            name: "Основы Python",
            questions: [
                // Single Choice вопросы
                Question(
                    id: UUID(),
                    text: "Что выведет print('Hello, World!')?",
                    answer: "Hello, World!",
                    answers: [
                        Answer(id: UUID(), text: "Hello, World!", isCorrect: true),
                        Answer(id: UUID(), text: "Привет, Мир!", isCorrect: false),
                        Answer(id: UUID(), text: "hello world", isCorrect: false),
                        Answer(id: UUID(), text: "Ничего, будет ошибка", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                Question(
                    id: UUID(),
                    text: "Какой тип данных используется для целых чисел в Python?",
                    answer: "int",
                    answers: [
                        Answer(id: UUID(), text: "int", isCorrect: true),
                        Answer(id: UUID(), text: "integer", isCorrect: false),
                        Answer(id: UUID(), text: "number", isCorrect: false),
                        Answer(id: UUID(), text: "num", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                Question(
                    id: UUID(),
                    text: "Какой оператор используется для возведения в степень в Python?",
                    answer: "**",
                    answers: [
                        Answer(id: UUID(), text: "^", isCorrect: false),
                        Answer(id: UUID(), text: "**", isCorrect: true),
                        Answer(id: UUID(), text: "pow()", isCorrect: false),
                        Answer(id: UUID(), text: "^^", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                Question(
                    id: UUID(),
                    text: "Какой метод используется для добавления элемента в конец списка?",
                    answer: "append()",
                    answers: [
                        Answer(id: UUID(), text: "add()", isCorrect: false),
                        Answer(id: UUID(), text: "append()", isCorrect: true),
                        Answer(id: UUID(), text: "insert()", isCorrect: false),
                        Answer(id: UUID(), text: "push()", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
            ],
            isCompleted: false
        ),
        
        Topic(
            id: UUID(),
            name: "Функции в Python",
            questions: [
                // Sequence вопросы
                Question(
                    id: UUID(),
                    text: "Составьте правильный синтаксис объявления функции",
                    answer: nil,
                    answers: nil,
                    answerSequence: [
                        Answer(id: UUID(), text: "def", isCorrect: nil),
                        Answer(id: UUID(), text: "function_name", isCorrect: nil),
                        Answer(id: UUID(), text: "()", isCorrect: nil),
                        Answer(id: UUID(), text: ":", isCorrect: nil)
                    ],
                    type: .sequence
                ),
                
                // Single Choice вопросы
                Question(
                    id: UUID(),
                    text: "Что такое lambda-функция?",
                    answer: "Анонимная функция",
                    answers: [
                        Answer(id: UUID(), text: "Функция без имени", isCorrect: true),
                        Answer(id: UUID(), text: "Функция с одним аргументом", isCorrect: false),
                        Answer(id: UUID(), text: "Функция которая возвращает None", isCorrect: false),
                        Answer(id: UUID(), text: "Функция с декоратором", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                Question(
                    id: UUID(),
                    text: "Какой символ используется для обозначения распаковки аргументов?",
                    answer: "*",
                    answers: [
                        Answer(id: UUID(), text: "&", isCorrect: false),
                        Answer(id: UUID(), text: "*", isCorrect: true),
                        Answer(id: UUID(), text: "#", isCorrect: false),
                        Answer(id: UUID(), text: "@", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                Question(
                    id: UUID(),
                    text: "Что такое декоратор в Python?",
                    answer: "Функция, которая принимает функцию и возвращает функцию",
                    answers: [
                        Answer(id: UUID(), text: "Функция для оформления кода", isCorrect: false),
                        Answer(id: UUID(), text: "Специальный синтаксис для классов", isCorrect: false),
                        Answer(id: UUID(), text: "Функция, изменяющая поведение другой функции", isCorrect: true),
                        Answer(id: UUID(), text: "Тип данных для хранения метаданных", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                
                // Sequence вопрос
                Question(
                    id: UUID(),
                    text: "Установите правильный порядок областей видимости в Python (от самой узкой к самой широкой)",
                    answer: nil,
                    answers: nil,
                    answerSequence: [
                        Answer(id: UUID(), text: "Локальная", isCorrect: nil),
                        Answer(id: UUID(), text: "Охватывающая", isCorrect: nil),
                        Answer(id: UUID(), text: "Глобальная", isCorrect: nil),
                        Answer(id: UUID(), text: "Встроенная", isCorrect: nil)
                    ],
                    type: .sequence
                )
            ],
            isCompleted: false
        ),
        
        Topic(
            id: UUID(),
            name: "ООП в Python",
            questions: [
                // Single Choice вопросы
                Question(
                    id: UUID(),
                    text: "Какой метод вызывается при создании объекта класса?",
                    answer: "__init__",
                    answers: [
                        Answer(id: UUID(), text: "__new__", isCorrect: false),
                        Answer(id: UUID(), text: "__init__", isCorrect: true),
                        Answer(id: UUID(), text: "__create__", isCorrect: false),
                        Answer(id: UUID(), text: "__start__", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                Question(
                    id: UUID(),
                    text: "Что такое наследование в Python?",
                    answer: "Возможность класса получать свойства другого класса",
                    answers: [
                        Answer(id: UUID(), text: "Создание копии класса", isCorrect: false),
                        Answer(id: UUID(), text: "Передача данных между классами", isCorrect: false),
                        Answer(id: UUID(), text: "Получение свойств родительского класса", isCorrect: true),
                        Answer(id: UUID(), text: "Сокрытие реализации класса", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                
                // Sequence вопросы
                Question(
                    id: UUID(),
                    text: "Расставьте в правильном порядке этапы при вызове метода объекта",
                    answer: nil,
                    answers: nil,
                    answerSequence: [
                        Answer(id: UUID(), text: "Поиск в классе объекта", isCorrect: nil),
                        Answer(id: UUID(), text: "Поиск в родительских классах", isCorrect: nil),
                        Answer(id: UUID(), text: "Создание bound метода", isCorrect: nil),
                        Answer(id: UUID(), text: "Выполнение метода", isCorrect: nil)
                    ],
                    type: .sequence
                ),
                Question(
                    id: UUID(),
                    text: "Укажите правильный порядок для объявления класса с наследованием",
                    answer: nil,
                    answers: nil,
                    answerSequence: [
                        Answer(id: UUID(), text: "class", isCorrect: nil),
                        Answer(id: UUID(), text: "ClassName", isCorrect: nil),
                        Answer(id: UUID(), text: "(ParentClass)", isCorrect: nil),
                        Answer(id: UUID(), text: ":", isCorrect: nil)
                    ],
                    type: .sequence
                ),
                
                // Single Choice вопрос
                Question(
                    id: UUID(),
                    text: "Что такое полиморфизм в Python?",
                    answer: "Возможность использовать один интерфейс для разных типов",
                    answers: [
                        Answer(id: UUID(), text: "Изменение типа объекта", isCorrect: false),
                        Answer(id: UUID(), text: "Наличие множества форм у метода", isCorrect: true),
                        Answer(id: UUID(), text: "Создание копий объектов", isCorrect: false),
                        Answer(id: UUID(), text: "Объединение нескольких классов", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                )
            ],
            isCompleted: false
        ),
        
        Topic(
            id: UUID(),
            name: "Работа с данными",
            questions: [
                // Sequence вопросы
                Question(
                    id: UUID(),
                    text: "Установите порядок операций при работе с файлом",
                    answer: nil,
                    answers: nil,
                    answerSequence: [
                        Answer(id: UUID(), text: "Открытие файла", isCorrect: nil),
                        Answer(id: UUID(), text: "Чтение/запись", isCorrect: nil),
                        Answer(id: UUID(), text: "Закрытие файла", isCorrect: nil)
                    ],
                    type: .sequence
                ),
                
                // Single Choice вопросы
                Question(
                    id: UUID(),
                    text: "Какой режим открывает файл для записи с очисткой содержимого?",
                    answer: "w",
                    answers: [
                        Answer(id: UUID(), text: "r", isCorrect: false),
                        Answer(id: UUID(), text: "w", isCorrect: true),
                        Answer(id: UUID(), text: "a", isCorrect: false),
                        Answer(id: UUID(), text: "x", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                Question(
                    id: UUID(),
                    text: "Какой модуль используется для работы с JSON в Python?",
                    answer: "json",
                    answers: [
                        Answer(id: UUID(), text: "json", isCorrect: true),
                        Answer(id: UUID(), text: "simplejson", isCorrect: false),
                        Answer(id: UUID(), text: "js", isCorrect: false),
                        Answer(id: UUID(), text: "datajson", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                ),
                
                // Sequence вопрос
                Question(
                    id: UUID(),
                    text: "Установите порядок обработки исключений в блоке try-except",
                    answer: nil,
                    answers: nil,
                    answerSequence: [
                        Answer(id: UUID(), text: "Выполнение кода в try", isCorrect: nil),
                        Answer(id: UUID(), text: "Возникновение исключения", isCorrect: nil),
                        Answer(id: UUID(), text: "Поиск подходящего except", isCorrect: nil),
                        Answer(id: UUID(), text: "Выполнение кода в except", isCorrect: nil),
                        Answer(id: UUID(), text: "Выполнение finally (если есть)", isCorrect: nil)
                    ],
                    type: .sequence
                ),
                
                // Single Choice вопрос
                Question(
                    id: UUID(),
                    text: "Какой метод используется для сериализации объекта в JSON?",
                    answer: "json.dumps()",
                    answers: [
                        Answer(id: UUID(), text: "json.save()", isCorrect: false),
                        Answer(id: UUID(), text: "json.dumps()", isCorrect: true),
                        Answer(id: UUID(), text: "json.encode()", isCorrect: false),
                        Answer(id: UUID(), text: "json.serialize()", isCorrect: false)
                    ],
                    answerSequence: nil,
                    type: .singleChoice
                )
            ],
            isCompleted: false
        )
    ]
}
#endif
