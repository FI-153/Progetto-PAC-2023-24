import java.util.ArrayList;
import java.util.List;

public class GestoreEvento {

    //...altri attributi e metodi...

    public List<User> selezionaIscritti(List<User> listaIscritti, Event event) {
        List<User> S = new ArrayList<>();
        int limiteMax = event.getMaxPeople();

        if (listaIscritti.size() <= limiteMax) {
            //se il numero di iscritti è inferiore del numero di posti, vengono tutti confermati
            S.addAll(listaIscritti);
        } else {
            int livelloTarget = event.getEventLevel();
            int i = 0;  // Numero di posti occupati
            int j = 0;  // Distanza dal livello target

            while ((i != limiteMax) && (!listaIscritti.isEmpty())) {
                User utenteConfermato = seleziona(listaIscritti, livelloTarget, j);
                if(utenteConfermato != null){
                    listaIscritti.remove(utenteConfermato);
                    S.add(utenteConfermato);
                    i++;
                }
                //se non ci sono altri iscritti di livello target +/- j e ci sono ancora posti liberi, si passa
                //a considerare gli iscritti con livello immediatamente inferiore o superiore
                boolean foundUser = false;
                for (User utente : listaIscritti) {
                    if (utente.getUserLevel() == livelloTarget + j || utente.getUserLevel() == livelloTarget - j) {
                        foundUser = true;
                    }
                }
                if (!foundUser) {
                    j++;
                }
            }
        }
        return S;
    }

    private User seleziona(List<User> listaIscritti, int livello, int distanza) {
        // Restituisce un utente con un livello pari a livello + distanza o livello - distanza
        for (User utente : listaIscritti) {
            if (utente.getUserLevel() == livello + distanza || utente.getUserLevel() == livello - distanza) {
                return utente;
            }
        }
        return null;
    }
}   
