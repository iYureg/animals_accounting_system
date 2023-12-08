package Core.MVP;

import Core.Infrastructure.Pets;
import Core.Models.Cat;
import Core.Models.Dog;
import Core.Models.Hamster;
import Core.Models.Pet;

import java.io.*;
import java.util.Random;

public class Model {
    Pets currentPets;
    private int currentIndex;
    private String path;

    public Model(String path) {
        currentPets = new Pets();
        currentIndex = 0;
        this.path = path;
    }

    public Pet currentPet() {
        if (currentIndex >= 0) {
            return currentPets.getPet(currentIndex);
        } else {
            return null;
        }
    }

    public void load() {
        try {
            File file = new File(path);
            FileReader fr = new FileReader(file);
            BufferedReader reader = new BufferedReader(fr);
            String name = reader.readLine();
            while (name != null) {
                String date = reader.readLine();
                String commands = reader.readLine();
                this.currentPets.add(
                        Creator.createNewPet(new Random().nextInt(1, 4), name, date, commands));
                name = reader.readLine();
            }
            reader.close();
            fr.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try (FileWriter writer = new FileWriter(path, false)) {
            for (int i = 0; i < currentPets.count(); i++) {
                Pet pet = currentPets.getPet(i);
                writer.append(String.format("%s\n", pet.getName()));
                writer.append(String.format("%s\n", pet.getBirthday()));
                writer.append(String.format("%s\n", pet.getCommands()));
            }
            writer.flush();
            writer.close();
        } catch (IOException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public Pets getCurrentPets() {
        return this.currentPets;
    }

    public int getCurrentIndex() {
        return this.currentIndex;
    }

    public void setCurrentIndex(int value) {
        this.currentIndex = value;
    }

    private class Creator {

        static Pet createNewPet(int type, String name, String date, String commands) {

            switch (type) {
                case 1:
                    return new Dog(name, date, commands);
                case 2:
                    return new Cat(name, date, commands);
                case 3:
                    return new Hamster(name, date, commands);
            }
            return null;
        }
    }
}
