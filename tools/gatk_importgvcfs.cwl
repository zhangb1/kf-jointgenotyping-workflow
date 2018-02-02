cwlVersion: v1.0
class: CommandLineTool
id: gatk_importgvcfs
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'kfdrc/gatk:4.beta.1'
baseCommand: [/gatk-launch]
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >-
      --javaOptions "-Xmx4g -Xms4g"
      GenomicsDBImport
      --genomicsDBWorkspace genomicsDBworkspace
      --batchSize 50
      -L $(inputs.interval)
      --sampleNameMap $(inputs.sampleNameMap.path)
      --readerThreads 5
      -ip 500 
      && tar -cf genomicsDBworkspace.tar genomicsDBworkspace
inputs:
  interval:
    type: string
  sampleNameMap:
    type: File
outputs:
  output:
    type: File
    outputBinding:
      glob: '*.tar'
