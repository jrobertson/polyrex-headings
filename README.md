# Introducing the Polyrex-headings gem

Tired of writing raw Polyrex documents in an indented format, I wrote this gem to make lists with headings more readable yet still be represented as a Polyrex document.


    require 'polyrex-headings'

    s=<<S
    <?ph schema="entries[title,tags]/entry[title]/tasks[title]"?>
    title: Daily tasks outline grouped by morning, afternoon, and evening
    tags: daily tasks gtd outline 10nov2012

    morning
    -------
    Pump of front tyre
    Go for a walk

    afternoon
    ---------

    Take a 20 min break
    Reply to email

    evening
    -------

    Read an Arduino tutorial
    S

    polyrex = PolyrexHeadings.new(s).to_polyrex
    puts polyrex.to_xml pretty: true

output:

    <?xml version='1.0' encoding='UTF-8'?>
    <entries>
      <summary>
        <title>Daily tasks outline grouped by morning, afternoon, and evening</title>
        <tags>daily tasks gtd outline 10nov2012</tags>
        <recordx_type>polyrex</recordx_type>
        <schema>entries[title,tags]/entry[title]/tasks[title]</schema>
        <format_mask>["[!title]", "[!title]"]</format_mask>
      </summary>
      <records>
        <entry id='1'>
          <summary>
            <title>morning</title>
            <format_mask>[!title]</format_mask>
          </summary>
          <records>
            <tasks id='2'>
              <summary>
                <title>Pump of front tyre</title>
                <format_mask>[!title]</format_mask>
              </summary>
              <records></records>
            </tasks>
            <tasks id='3'>
              <summary>
                <title>Go for a walk</title>
                <format_mask>[!title]</format_mask>
              </summary>
              <records></records>
            </tasks>
          </records>
        </entry>
        <entry id='4'>
          <summary>
            <title>afternoon</title>
            <format_mask>[!title]</format_mask>
          </summary>
          <records>
            <tasks id='5'>
              <summary>
                <title>Take a 20 min break</title>
                <format_mask>[!title]</format_mask>
              </summary>
              <records></records>
            </tasks>
            <tasks id='6'>
              <summary>
                <title>Reply to email</title>
                <format_mask>[!title]</format_mask>
              </summary>
              <records></records>
            </tasks>
          </records>
        </entry>
        <entry id='7'>
          <summary>
            <title>evening</title>
            <format_mask>[!title]</format_mask>
          </summary>
          <records>
            <tasks id='8'>
              <summary>
                <title>Read an Arduino tutorial</title>
                <format_mask>[!title]</format_mask>
              </summary>
              <records></records>
            </tasks>
          </records>
        </entry>
      </records>
    </entries>

## Example 2

    require 'polyrex-headings'

    s1=&lt;&lt;S
    &lt;?ph schema="entries[title,tags]/entry[title]/tasks[title]"?&gt;
    title: Daily tasks outline grouped by morning, afternoon, and evening
    tags: daily tasks gtd outline 16jul2014

    # morning

    Pump up front tyre
    Go for a walk

    # afternoon

    Take a 20 min break
    Reply to email

    # evening

    Read an Arduino tutorial
    S
    polyrex = PolyrexHeadings.new(s1).to_polyrex
    puts polyrex.to_xml pretty: true



polyrex-headings polyrex parser extension gem

