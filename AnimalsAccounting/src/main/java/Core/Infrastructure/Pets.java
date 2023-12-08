package Core.Infrastructure;

import Core.Models.Pet;

import java.util.ArrayList;
import java.util.List;

public class Pets {
    private List<Pet> pets;

    public Pets() {
        pets = new ArrayList<Pet>();
    }

    // create
    public boolean add(Pet pet) {
        boolean flag = false;
        if (!pets.contains(pet)) {
            pets.add(pet);
            flag = true;
        }
        return flag;
    }

    // read
    public Pet getPet(int index) {
        return contains(index) ? pets.get(index) : null;
    }

    // update
    public boolean update(Pet pet, String value) {
        boolean flag = false;
        if (pets.indexOf(pet) != -1) {
            pet.setCommand(value);
            flag = true;
        }
        return flag;
    }

    // delete
    public boolean remove(Pet pet) {
        boolean flag = false;
        if (pets.indexOf(pet) != -1) {
            pets.remove(pet);
            flag = true;
        }
        return flag;
    }

    private boolean contains(int index) {
        return pets != null && pets.size() > index;
    }

    public List<Pet> getPets() {
        return pets;
    }

    public int count() {
        return pets.size();
    }
}
