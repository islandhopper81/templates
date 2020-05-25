nextflow.preview.dsl=2

cont = ''

params.publish = false

process MY_MOD {
    tag "$ptag"
    echo true
    container "$cont"
    publishDir "$out_dir", mode: "copy", enabled: params.publish

    input:
        val ptag
        val out_dir
        
    output:
        //path "*.txt", emit: txts

    script:
        """
        echo "$ptag"
        """
}

process MY_MOD_usage {
    container "$cont"
    echo true
    validExitStatus 0,1

    script:
    """
    man echo
    """
}

workflow {
    main:
        if ( params.help ) {
            MY_MOD_usage()
        }
        else {
            // instantiate channels
            ch_ptag = Channel.from("test")

            // call the workflow
            MY_MOD(ch_ptag, 'test/')
        }
}

