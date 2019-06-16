---
layout: single
title: Git History Graphs
context: Ramblings
date: 2019-06-14
categories: blog
comments: true
---

This is more of a reminder for myself so that I can remember how to edit my banner image.

I was looking for a way to generate pretty git graphs for my webpage to showcase my professional progression when I stumpled upon this [stackoverflow post](https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs). From there I followed one of the answers to [gitdags](https://github.com/ianmiell/gitdags) repo. I would encourage new users to use the supplied docker image to save yourself from installing numerous software packages like I did.

Here is the source of my `tex` file to generate my banner image:
```
\documentclass[preview]{standalone}
%\documentclass{article}
\usepackage[a4paper, landscape, total={20in, 20in}, margin=0pt]{geometry}



\usepackage{subcaption}
\usepackage{gitdags}

\begin{document}

\begin{figure}
  \begin{subfigure}[b]{\textwidth}
    \centering
    \begin{tikzpicture}
      % Commit DAG
      \gitDAG[grow right sep = 2.5em, branch down=4em]{
          1989[xshift=-4em] -- 2011 -- feb --     
          {  microchip{-}technology[yshift=2em, xshift=0em] -- 2014[yshift=2em] -- blockwise{-}engineering[yshift=2em] -- 2017[yshift=2em] --  agjunction[yshift=2em] -- 2019[yshift=2em] -- axon[yshift=2em] ,  
            sphinx{-}search[xshift=0em, yshift=0em] -- http{://}mcuhq{.}com -- http{://}bauerjj{.}github{.}io[yshift=0em] }
           -- justin{-}bauer
      };
      % Tag reference
      \gittag
        [v0p1]       % node name
        {electrical\char`_engineering}       % node text
        {above=of 2011} % node placement
        {2011}  
      \gittag
        [v0p2]       % node name
        {rose-hulman\char`_inst\char`_of\char`_tech}       % node text
        {above=of v0p1} % node placement
        {v0p1}          % target        % target
      \gittag
        [appEngineer]       % node name
        {applications\char`_engineer}       % node text
        {above=of microchip{-}technology} % node placement
        {microchip{-}technology}
      \gittag
        [bwisejob]       % node name
        {embedded\char`_electrical\char`_engineer}       % node text
        {above=of blockwise{-}engineering} % node placement
        {blockwise{-}engineering} 
      \gittag
        [agjunctionjob]       % node name
        {embedded\char`_software\char`_engineer}       % node text
        {above=of agjunction} % node placement
        {agjunction} 
      \gittag
        [axonjob]       % node name
        {senior\char`_software\char`_engineer}       % node text
        {above=of axon} % node placement
        {axon} 
      % Remote branch
      \gitremotebranch
        [origmaster]    % node name
        {origin/master} % node text
        {above=of 1989}    % node placement
        {1989}             % target
      % Branch
      \gitbranch
        {chicago{-}il}     % node name and text 
        {below=of 1989} % node placement
        {1989}          % target
      \gitbranch
        {indy-in}     % node name and text 
        {below=of 2011} % node placement
        {2011}          % target
      \gitbranch
        {tempe{-}az}     % node name and text 
        {below=of feb} % node placement
        {feb}          % target
      \gitHEAD
        {above=of justin{-}bauer} % node placement
        {justin{-}bauer}          % target
      \gitbranch
        {dev{-}hobby}     % node name and text 
        {below=of sphinx{-}search} % node placement
        {sphinx{-}search}          % target
      \gitbranch
        {dev{-}hobby}     % node name and text 
        {below=of http{://}mcuhq{.}com} % node placement
        {http{://}mcuhq{.}com}          % target
      \gitbranch
        {dev{-}hobby}     % node name and text 
        {below=of http{://}bauerjj{.}github{.}io} % node placement
        {http{://}bauerjj{.}github{.}io}          % target
    \end{tikzpicture}
  \end{subfigure}


 
\end{figure}

\end{document}
```

