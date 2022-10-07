// Diploid is default in SLiM and also tricky to disable, so leaving it for now.
// Can implement haploid but it's a little annoying: 14.9 Modeling haploid organisms 


species all initialize() {
    defineConstant("S", 10);
    defineConstant("K", 5000); 
}

{species_blocks}

ticks all 1 early() {
    // Init all species sizes sampled from loguniform distribution
    //
    // Setting species sizes by hand is like this:
    //    fox.addSubpop("p0", 1000);
    //    mouse.addSubpop("p1", 5000);
    sizes = asInteger(rlnorm(S, meanlog=log(K), sdlog=1));

    for (idx in seqAlong(community.allSpecies)){
        community.allSpecies[idx].addSubpop("p"+idx, sizes[idx]);
    }

    // Set up logging
    log = community.createLogFile("com_log.txt", logInterval=20);
    for (idx in seqAlong(community.allSpecies)){
        log.addCustomColumn("N_p"+idx, "p"+idx+".individualCount;");
    }
    for (idx in seqAlong(community.allSpecies)){
        log.addCustomColumn("H_p"+idx, "calcHeterozygosity(p"+idx+".genomes);");
    }
}

ticks all early() {
    sizes = community.allSubpopulations.individualCount;

    // Fix community size to exactly K and sample new abundances per species
    // as a function of proportional abundance in the previous timestep.
    newsizes = rbinom(size(sizes), K, sizes/sum(sizes));

    // Alternative:
    // Allow community size to 'wander' around the total size initialized
    // newsizes = rbinom(size(sizes), sum(sizes), sizes/sum(sizes));

    for (idx in seqAlong(community.allSubpopulations)){
        community.allSubpopulations[idx].setSubpopulationSize(newsizes[idx]);
    }
}

ticks all 100 late() {
    for (p in community.allSubpopulations)
        catn(c(p.name, p.individualCount)) ;
    catn(sum(community.allSubpopulations.individualCount));
} 

