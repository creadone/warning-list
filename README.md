# Warning List
Обновляемый список компаний с выявленными признаками нелегальной деятельности на финансовом рынке по данным [Банка России](https://www.cbr.ru/inside/warning-list/):

* `[data/full.csv](https://github.com/creadone/warning-list/blob/main/data/full.csv)` — полный список
* `[data/sites.csv](https://github.com/creadone/warning-list/blob/main/data/sites.csv)` — только URL'ы из колонки «Сайт»

### Обновление вручную:
Установить гемы:
```
bundle install
```

Обновить список:
```
bundle exec ruby update.rb
```
