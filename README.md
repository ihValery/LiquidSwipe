# LiquidSwipe
    
<img src="https://github.com/ihValery/LiquidSwipe/blob/main/LiquidSwipe/Assets.xcassets/AppIcon.appiconset/Icon-83.5%402x.png"></a>
- Challenger:
    - Красивые свайпы с shape

- Архитектура: MVVM (с примесями VOODO @Mark Moeykens)
- Warning: All interface orientations must be supported unless the app requires full screen.
- Ставим галочку: Requires full screen

- 1 Модель - var offset: CGSize = .zero
- 2 ForEach(..indices.reversed()) - indices...так как offset обновляется в реальном времени
- 3 Shape фигуру нужной формы, тут кривые Безье
- 4 faceIndex u currentIndex (для иллюзии бесконечности)
- 5 В .clipShape(передаем offset: oo.data[index])
- 6 В .gesture(.onChanged { value in oo.data[currentIndex].offset = value.translation )}
- 7 Логика отработки жестов(что хотим)
- 8 .onAppear { Меняем последний элемент с первым }
- 9 Дошли до .count-2 (массиив же увеличился) пробежаться по нему и обнулить offset
- 10 Обновляем оригинальный индекс
- 11 - 12 - 13 - 14 - 15
