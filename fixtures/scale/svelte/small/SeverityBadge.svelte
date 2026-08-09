<script>
  export let level = 'info';

  function badgeTone() {
    return level === 'error' ? '#c25b4e' : level === 'warning' ? '#d08b2c' : '#5a86ad';
  }
</script>

<span class="severity-badge" style="background: {badgeTone()}">{level}</span>

<style>
  .severity-badge {
    color: #fff;
    border-radius: 4px;
    padding: 0 0.4rem;
    font-size: 0.7rem;
    text-transform: uppercase;
  }
</style>
