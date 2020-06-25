workflow test_location {
    call find_tools
}

task find_tools {
    command {
        ls $BEDTOOLS_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $TABIX_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $VEP_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $CONDA_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $VCFTOOLS_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $PERL_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $BCFTOOLS_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $HTSLIB_ROOT
        echo "@@@@@@@@@@@@@@@@"
        whereis bgzip
        echo "@@@@@@@@@@@@@@@@"

        echo $PATH
        echo "################"
        echo $MANPATH
        echo "################"
        echo $LD_LIBRARY_PATH
        echo "################"
        echo $PERL5LIB
        echo "################"
        echo $PKG_CONFIG_PATH
        echo "################"
        echo $PYTHONPATH
        echo "################"
        echo $LD_RUN_PATH
        echo "################"
    }
    output{
        String message = read_string(stdout())
    }
    runtime {
        docker: "g3chen/varianteffectpredictor:2.0"
        modules: "bedtools/2.27 tabix/0.2.6 vep/92.0 vcftools/0.1.16 bcftools/1.9"
    }
}
