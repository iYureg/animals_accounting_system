package Core.MVP;

import Core.Models.Pet;

public class Presenter {
    private Model model;
    private View view;

    public Presenter(View view, String pathDb) {
        this.view = view;
        model = new Model(pathDb);
    }

    public void LoadFromFile() {
        model.load();

        if (model.getCurrentPets().count() > 0) {
            model.setCurrentIndex(0);
            var pet = model.currentPet();

            view.setName(pet.getName());
            view.setDate(pet.getBirthday());
            view.setCommands(pet.getCommands());
        }
    }

    public void add() {
        model.getCurrentPets().add(
                new Pet(view.getName(), view.getDate(), view.getCommands()));
    }

    public void update(String value) {
        model.currentPets.getPet(model.getCurrentIndex()).setCommand(value);
    }

    public void seveToFile() {
        model.save();
    }

    public void next() {
        if (model.getCurrentPets().count() > 0) {
            if (model.getCurrentIndex() + 1 < model.getCurrentPets().count()) {
                model.setCurrentIndex(model.getCurrentIndex() + 1);
                Pet pet = model.currentPet();
                view.setName(pet.name);
                view.setDate(pet.birthday);
                view.setCommands(pet.getCommands());
            }
        }
    }

    public void prev() {
        if (model.getCurrentPets().count() > 0) {
            if (model.getCurrentIndex() - 1 > -1) {
                model.setCurrentIndex(model.getCurrentIndex() - 1);
                Pet pet = model.currentPet();
                view.setName(pet.name);
                view.setDate(pet.birthday);
                view.setCommands(pet.getCommands());
            }
        }
    }
}
