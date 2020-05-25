nextflow.preview.dsl=2

params.out_dir = "./"

// map to reference
include MY_MOD as MY_MOD from './modules/mod.nf'

workflow subwf {
    main:
        MY_MOD(
            "test",
            "test/"
        )
}

// main workflow
workflow {
    main: 
        MY_MOD()
}
