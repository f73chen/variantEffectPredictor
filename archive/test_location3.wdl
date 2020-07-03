workflow test_location {
    call find_tools
}

task find_tools {
    command {
        ls -l /data/HG19_ROOT/hg19_random.fa
        echo "@@@@@@@@@@@@@@"
        ls -l /data/VEP_HG19_CACHE_ROOT/.vep
        echo "@@@@@@@@@@@@@@"
        ls -l $VEP_ROOT/bin/
        echo "@@@@@@@@@@@@@@"
        ls -l /data/VEP_HG19_EXAC_ROOT/ExAC_nonTCGA.r0.3.1.somatic.sites.vep.vcf.gz
        echo "@@@@@@@@@@@@@@"
    }
    output{
        String message = read_string(stdout())
    }
    runtime {
        docker: "g3chen/varianteffectpredictor:2.0"
        modules: "bedtools/2.27 vcftools/0.1.16 bcftools/1.9 vcf2maf/1.6.17"
    }
}
