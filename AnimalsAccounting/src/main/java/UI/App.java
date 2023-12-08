package UI;

import Core.Infrastructure.Counter;
import Core.MVP.Presenter;
import Core.MVP.View;

import java.util.Scanner;

public class App {

    public static void ButtonClick() {
        System.out.print("\033[H\033[J");
        View view = new NewConsoleView();
        Presenter presenter = new Presenter(view, "data.txt");
        presenter.LoadFromFile();
        StringBuilder menu = new StringBuilder()
                .append(" =====================\n")
                .append(" 1 - previous pet\n")
                .append(" 2 - next pet\n")
                .append(" 3 - add new pet\n")
                .append(" 4 - train pet\n")
                .append(" 0 - save & exit\n")
                .append(" =====================\n");

        Counter count = new Counter();
        try (Scanner in = new Scanner(System.in)) {
            while (true) {
                System.out.println(menu.toString());
                String key = in.next();
                System.out.print("\033[H\033[J");

                switch (key) {
                    case "1":
                        presenter.prev();
                        break;
                    case "2":
                        presenter.next();
                        break;
                    case "3":
                        try (count) {
                            presenter.add();
                            count.add();
                            break;
                        } catch (RuntimeException e) {
                            // TODO: handle exception
                            System.out.println("not added");
                        }

                    case "4":
                        presenter.update(in.next());
                        break;
                    case "0":
                        presenter.seveToFile();
                        return;
                    default:
                        System.out.printf("command not exists\n");
                        break;
                }
            }
        }
    }
}
