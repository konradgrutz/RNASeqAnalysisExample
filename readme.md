
# RNA-Seq pipeline demonstration

## notes 
- demonstrate clustering and diff. gene expression analysis scripts in jupyter
- at IMB comp1, because CMTD conda doesn't work currently
- based on CMTD project 063-2019-KuhlmannZytostatika
- we start with feature counts as R object also containing totalReads (featCount-noMultiMap.RData)


## pre-requesites

- install qqpdf 
- install ImageMagick and get the path of its convert -> insert into scripts/deseq2.r.ipynb
- conda environment
  - setup conda environment:

```
conda create --name RNASeqExampleKG -c r r-base r-essentials r-irkernel r-devtools bioconductor-deseq2 r-ggplot2 bioconductor-rsubread r-scales r-gridextra r-rsubread r-circlize r-ggrepel 
```

  - then activate the conda and call jupyter
```
activate RNASeqExampleKG
jupyter notebook
```

  - or jupyter notebook via ssh tunnel
  - on server site `jupyter notebook --port=9003 --no-browser`
  - on client site `ssh -N -L 9003:localhost:9003 userlogin@server.com`

  - try to install and initialize libraries r-xlconnect/r-xlsx to also use the uncommented lines of script to export as xls Excel file


## clustering

...

## differential gene expression


...
