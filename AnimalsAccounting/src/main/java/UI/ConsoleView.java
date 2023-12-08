package UI;

import Core.MVP.View;
import java.util.Scanner;

public class ConsoleView implements View {
    Scanner in;

    public ConsoleView() {
        in = new Scanner(System.in);
    }

    @Override
    public String getName() {
        System.out.printf("Кличка: ");
        return in.nextLine();
    }

    @Override
    public void setName(String value) {
        System.out.printf("Кличка: %s\n", value);
    }

    @Override
    public String getDate() {
        System.out.printf("Дата рождения: ");
        return in.nextLine();
    }

    @Override
    public void setDate(String value) {
        System.out.printf("Дата рождения: %s\n", value);
    }

    @Override
    public String getCommands() {
        System.out.printf("Умения: ");
        return in.nextLine();
    }

    @Override
    public void setCommands(String value) {
        System.out.printf("Умения: %s\n", value);
    }
}
