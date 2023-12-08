package UI;

public class NewConsoleView extends ConsoleView {
    public NewConsoleView() {
        super();
    }

    @Override
    public void setCommands(String value) {
        super.setCommands(value);
        System.out.println();
    }
}
