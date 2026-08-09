<script>
  import SeverityBadge from './SeverityBadge.svelte';

  export let text = '';
  export let number = 0;

  function severityOf(raw) {
    if (raw.includes('error')) return 'error';
    return raw.includes('warning') ? 'warning' : 'info';
  }
</script>

<div class="output-line">
  <span class="line-no">{number}</span>
  <SeverityBadge level={severityOf(text)} />
  <span>{text}</span>
</div>

<style>
  .output-line {
    display: grid;
    grid-template-columns: 3rem auto 1fr;
    gap: 0.5rem;
  }
</style>
