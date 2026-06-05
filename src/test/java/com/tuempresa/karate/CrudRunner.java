package com.tuempresa.karate;

import com.intuit.karate.junit5.Karate;

class CrudRunner {

    @Karate.Test
    Karate testCrud() {
        return Karate.run("crud").relativeTo(getClass());
    }

    @Karate.Test
    Karate testSoloCreate() {
        return Karate.run("crud").tags("@create").relativeTo(getClass());
    }

    @Karate.Test
    Karate testSoloRead() {
        return Karate.run("crud").tags("@read").relativeTo(getClass());
    }

    @Karate.Test
    Karate testSoloUpdate() {
        return Karate.run("crud").tags("@update").relativeTo(getClass());
    }

    @Karate.Test
    Karate testSoloDelete() {
        return Karate.run("crud").tags("@delete").relativeTo(getClass());
    }
}
