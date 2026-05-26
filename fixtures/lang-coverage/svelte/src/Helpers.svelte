<script>
  export let label = 'default';

  function formatLabel(l) {
    return 'hi, ' + l;
  }

  $: displayLabel = formatLabel(label);
</script>

<span>{displayLabel}</span>
