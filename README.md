# myRecipe — приложение для поиска и сохранения понравившихся рецептов

Для поиска рецептов выбрал <a href = "https://spoonacular.com/food-api">spoonacular API</a><br>
Архитектура — MVVM. ViewModel связывается обычными замыканиями<br>
Добавил анимацию при входе в приложение и свой анимированный спиннер загрузки

### Первый экран — поиск рецептов
При запуске подгружаются несколько рандомных рецептов. Загрузка начинается одновременно с запуском стартовой анимации и по ее окончании данные уже отображены<br><br>
[![random.png](https://i.postimg.cc/hjkHz7BJ/random.png)](https://postimg.cc/nj1dNrMZ)

Рецепты можно искать с помощью большого количества параметров<br><br>
[![search-Parameters.png](https://i.postimg.cc/BnSRK0dC/search-Parameters.png)](https://postimg.cc/MvL9ChZc)

Или можно просто начать вводить запрос и приложение предложит варианты<br><br>
[![search-Autocomplete.png](https://i.postimg.cc/pXYgrT1T/search-Autocomplete.png)](https://postimg.cc/dL3WSqFP)

### Результат поиска — фото и название рецепта. При скролле подгружаются дополнительные
[![search.png](https://i.postimg.cc/MG4LNjXs/search.png)](https://postimg.cc/5HBpFyBv)

### При нажатии открывается страница с детальным описанием рецепта
Внизу страницы — карусель похожих рецептов<br><br>
[![recipe.png](https://i.postimg.cc/rpzbf9y0/recipe.png)](https://postimg.cc/hJWpjTdc)

### Также можно посмотреть какие питательные вещества содержит выбранное блюдо, их количество и процент от дневной нормы
[![nutrients.png](https://i.postimg.cc/fyY1xTz8/nutrients.png)](https://postimg.cc/n9cdxxQm)

### На второй вкладке находятся сохраненные рецепты, отсортированные по дате добавления в Core Data. В них можно ориентироваться при помощи поиска
[![saved.png](https://i.postimg.cc/9QLKPk2H/saved.png)](https://postimg.cc/gx6gmNrg)

### Третья вкладка — поиск рецептов по ингредиентам или "Что у Вас в холодильнике?"
Здесь тоже есть автодополнение поиска, но уже с картинками<br><br>
[![inFridge.png](https://i.postimg.cc/KYHXbHpD/inFridge.png)](https://postimg.cc/VSnZBD8J)

### Результат поиска выглядит точно так же, как и обычный поиск. Отсюда можно начать новый
[![in-Fridge-Results.png](https://i.postimg.cc/50Yh2SZd/in-Fridge-Results.png)](https://postimg.cc/hznyCTDp)

### Последняя вкладка — настройки
При выборе индивидуальных непереносимостей, поиск рецептов всегда будет осуществляться с учетом этого параметра (при поиске рецептов по ингредиентам не учитывается)<br>
Выбор предпочитаемых единиц измерения учитывается при просмотре рецепта<br>
Выбранные настройки сохраняются в UserDefaults<br><br>
[![settings.png](https://i.postimg.cc/gJZ7WkZG/settings.png)](https://postimg.cc/wy925z2r)
