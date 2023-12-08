package Core.Models;

public class Pet {

    public String name;
    public String birthday;
    public StringBuilder commands = new StringBuilder("");

    public Pet(String name, String birthday, String command) {
        this.name = name;
        this.birthday = birthday;
        this.commands.append(command);
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void setBirthday(String date) {
        this.birthday = date;
    }

    public String getBirthday() {
        return this.birthday.toString();
    }

    public void setCommand(String value) {
        if (this.commands.isEmpty()) {
            this.commands.append(value);
        } else {
            this.commands
                    .append(", ")
                    .append(value);
        }
    }

    public String getCommands() {
        return this.commands.toString();
    }
}
