ngrams_single_document <- function(j,
                                   ngram_lengths,
                                   remove_punctuation,
                                   remove_numeric,
                                   lemmatize,
                                   lowercase,
                                   tokenized_documents,
                                   EXTRACT_NGRAMS,
                                   JK_filtering,
                                   verb_filtering,
                                   phrase_extraction){
    tokenized_document <- tokenized_documents[[j]]
    # initialize list object
    current <- list()
    current$ngrams <- NA
    current$jk_filtered <- NA
    current$verb_filtered <- NA
    current$phrases <- NA
    current$ngram_lengths <- ngram_lengths
    current$remove_punctuation <- remove_punctuation
    current$remove_numeric <- remove_numeric
    current$lemmatize <- lemmatize
    current$lowercase <- lowercase
    current$null_document <- FALSE

    if (is.null(tokenized_document)) {
        warning(
            paste("NULL document provided! Please check input! Document index:",
                j))
        current$null_document <- TRUE
    } else {
        if (EXTRACT_NGRAMS) {
            current$ngrams <- extract_ngrams(
                tokenized_document = tokenized_document,
                ngram_lengths = ngram_lengths,
                remove_punctuation = remove_punctuation,
                remove_numeric = remove_numeric,
                lemmatize = lemmatize,
                lowercase = lowercase)
        }
        if (JK_filtering) {
            current$jk_filtered <- extract_jk(
                tokenized_document = tokenized_document,
                lemmatize = lemmatize,
                lowercase = lowercase
            )
        }
        if (verb_filtering) {
            current$verb_filtered <- extract_verbs(
                tokenized_document = tokenized_document,
                lemmatize = lemmatize,
                lowercase = lowercase
            )
        }
        if (phrase_extraction) {
            stop("phrase_extraction not currently implemented")
            # current$phrases <- extract_phrases(
            #     tokenized_document = tokenized_document,
            #     lemmatize = lemmatize,
            #     lowercase = lowercase
            # )
        }
    }
    return(current)
}
