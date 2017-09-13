component accessors=true {
    property Logger;

    void function default(struct rc) {
        Logger.getLogger(this).fatal("Oh no an error!");
    }
}
