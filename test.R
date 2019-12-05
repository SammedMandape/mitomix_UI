library(shiny)
library(DT)
shinyApp(
  ui = fluidPage(DTOutput('tbl')),
  server = function(input, output) {
    output$tbl = renderDT(
      #iris, options = list(lengthChange = FALSE), formatS
      datatable(head(iris), rownames = FALSE) %>% {height: 894px;}
       # formatStyle(., # select all columns in table
        #            height = 5), # set height of rows
      #options = list(lengthChange = FALSE, searching = FALSE, pageLength = 2)
    )
  }
)


readEmpop<-read_lines("tmp-000002836_empop_confirmed1459.txt")
class(readEmpop)
variants<-strsplit(readEmpop[2], '\t')
class(variants)
variants_UL<-unlist(variants)
class(variants_UL)
variants_ul_df<-tibble::enframe(variants_UL[-(1:3)])
#str_detect(variants_UL, "\\.")
#del<-str_c(c("\\.","del","[acgt]"), collapse = "|")
#str_replace_all(variants_UL, del, "")
variants_filtered<-variants_ul_df %>% filter(!str_detect(value, "\\.|del|[acgt]"))
variants_decoded<-variants_filtered %>% separate(value, into = c("pos","allele"), sep = "(?<=[0-9])(?=[A-Z])") %>% 
