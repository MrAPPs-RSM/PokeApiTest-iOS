# Librerie utilizzate

* **Alamofire**
Libreria utilizzata per migliore uso delle request alle api
* **PureLayout**
Libreria utilizzata come wrapper della creazione dei layout tramite constraint, migliora leggibilità e sviluppo.
* **SDWebImage**
Libreria utilizzata per il caching delle immagini renderizzate tramite url remoto
* **RealmSwift**
Libreria utilizzata come database locale
* **ObjectMapper**
Libreria utilizzata per il mapping dei dati ricevuti dalle api nei modelli del database

# Descrizione progetto

Il progetto viene avviato in una splash screen di configurazione, dove verranno scaricati tutti i dati dei tipi, statistiche e pokemon.
In quanto giocatore del brand Pokémon da 23 anni e utilizzatore di software similari l'approccio al salvataggio e fruizione dei dati è stato quello di scaricare tutte le informazioni prima del reale utilizzo dell'app, per rendere possibile la consultazione completamente offline.
La scelta è stata influenzata anche dal modo in cui sono state realizzate le API di PokèApi, sicuramente non favorevoli ad un utilizzo mobile, ne per fruizione che per gestione della grafica.

Conclusa la configurazione iniziale si atterra in una tabbar divisa tra elenco pokemon ed elenco preferiti. Entrambe le griglie sono configurate per modificare il numero di colonne a video in base al dispositivo (iPhone/iPad) e relativa rotazione (iPhone solo portrait).

L'aggiunta/rimozione dai preferiti di un Pokémon riceve un update grafico istantaneo in entrambe le griglie nonchè nella schermata di dettaglio del singolo Pokémon.

Al tap di un elemento della griglia verrà aperto il dettaglio, nel quale vengono visualizzati i dati già presenti precedentemente oltre alla sprite del modello shiny del Pokémon visualizzato.
Inoltre, le statistiche sono state renderizzate riprendendo colori e stile del sito di riferimento Bulbapedia.

# Features aggiuntive

* Dark mode
* Multilingua it/en
* Preferiti
* Ricerca
