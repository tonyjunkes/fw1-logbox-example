component accessors=true {
    property Logger;

    void function default(struct rc) {
        variables.Logger.getLogger(this).fatal("Oh no an error!");
    }
}
